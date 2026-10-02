[CmdletBinding()]
param([switch]$Baseline, [switch]$Diagnostic, [string]$WorkDirectory, [string]$TestFilter='.*')
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$SourceRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (!$WorkDirectory) { $WorkDirectory = Join-Path $SourceRoot '.grm-git-acceptance-work' }
$RunRoot = Join-Path $WorkDirectory ([DateTime]::UtcNow.ToString('yyyyMMddTHHmmssfffffff'))
$null = New-Item -ItemType Directory -Path $RunRoot
$RealGit = (Get-Command git.exe -CommandType Application | Select-Object -First 1).Source
$Utf8 = New-Object Text.UTF8Encoding($false)
$Results = New-Object 'System.Collections.Generic.List[object]'
function Record([string]$Name, [scriptblock]$Check) {
    if ($Name -notmatch $TestFilter) {return}
    try { & $Check; $Results.Add([pscustomobject]@{Test=$Name; Result='PASS'}); Write-Output "PASS $Name" }
    catch { $Results.Add([pscustomobject]@{Test=$Name; Result='FAIL'; Reason=$_.Exception.Message}); Write-Output "FAIL $Name" }
}
function Assert([bool]$Condition, [string]$Message) { if (!$Condition) { throw $Message } }
function Write-Text([string]$Path, [string]$Text) {
    $null = New-Item -ItemType Directory -Force -Path (Split-Path -Parent $Path)
    [IO.File]::WriteAllText($Path,$Text,$Utf8)
}
$Catalogue = [IO.File]::ReadAllText((Join-Path $SourceRoot 'documentation/G_SCRIPTS.md'))
$Tokens=$null; $Errors=$null
$DispatcherAst = [Management.Automation.Language.Parser]::ParseFile(
    (Join-Path $SourceRoot 'documentation/I_SCRIPTS.ps1'),[ref]$Tokens,[ref]$Errors)
Assert ($Errors.Count -eq 0) 'Dispatcher syntax failure'
foreach ($Name in @('Get-GrmProcedure','Get-GrmGitSupport')) {
    $Nodes = @($DispatcherAst.FindAll({param($n) $n -is [Management.Automation.Language.FunctionDefinitionAst] -and $n.Name -ceq $Name},$true))
    Assert ($Nodes.Count -eq 1) "Dispatcher definition ambiguous: $Name"
    . ([scriptblock]::Create($Nodes[0].Extent.Text))
}
foreach ($Id in @('GS-GIT-01','GS-GIT-02','GS-GIT-03','GS-GIT-04','GS-GIT-05')) {
    Record "registration/syntax $Id" {
        $Body=Get-GrmProcedure $Id; $t=$null; $e=$null
        $null=[Management.Automation.Language.Parser]::ParseInput($Body.ToString(),[ref]$t,[ref]$e)
        Assert ($e.Count -eq 0) 'Catalogue syntax failure'
    }
}
. (Get-GrmGitSupport)
foreach ($Path in @('documentation/GRM.md','documentation/G_SCRIPTS.md','documentation/I_SCRIPTS.ps1')) {
    Record "current publishability $Path" { Assert-Git03Document $Path ([IO.File]::ReadAllText((Join-Path $SourceRoot $Path))) }
}
Record 'canonical bracket publication policy' {
    $Stopped=$false
    try { Assert-Git03PublishPath 'documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md' }
    catch { $Stopped=$true }
    Assert (!$Stopped) 'Canonical bracket publication path was rejected'
}
Record 'historical caller uses actual HEAD revision' {
    $Body=(Get-GrmProcedure 'GS-GIT-03').ToString()
    $FixedLabel=$Body.Contains("Assert-Git03HistoricalDocument '8143e4bde109427d63670057cd6612b89292474e' " + '$Path')
    Assert (!$FixedLabel) 'Historical HEAD content is labelled with a fixed source revision'
}
if (!$Baseline) {
    Record 'noncanonical brackets remain rejected' {
        $Stopped=$false; try { Assert-Git03PublishPath 'documentation/[arbitrary]/x.md' } catch {$Stopped=$true}
        Assert $Stopped 'Unrestricted bracket policy'
    }
}
if ($Baseline) {
    $Results | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $RunRoot 'results.json') -Encoding UTF8
    $Results | Format-Table -AutoSize
    Write-Output "Evidence: $RunRoot"
    if (@($Results | Where-Object Result -eq 'FAIL').Count) {throw 'Baseline validation failed'}
    return
}

# Controlled executable adapter: only fetch/pull/push transport is redirected.
# Production config inspections still see the canonical GitHub origin. No
# production guard is replaced. Fixtures cannot issue network transport.
$AdapterDirectory=Join-Path $RunRoot 'adapter'
$null=New-Item -ItemType Directory -Path $AdapterDirectory
$GitLiteral=$RealGit.Replace('"','""')
$AdapterSource=@'
using System;
using System.IO;
using System.Diagnostics;
using System.Collections.Generic;
public class FixtureGit {
 public static string Q(string s) {
  return "\"" + System.Text.RegularExpressions.Regex.Replace(
   System.Text.RegularExpressions.Regex.Replace(s, @"(\\*)""", "$1$1\\\""), @"(\\+)$", "$1$1") + "\"";
 }
 public static int Main(string[] args) {
  string cwd=Environment.CurrentDirectory;
  string map=Path.Combine(cwd,".git","fixture-remote");
  bool transport=false, push=false, fetch=false;
  foreach(string a in args) { if(a=="fetch"||a=="push"||a=="pull") transport=true; if(a=="push") push=true; if(a=="fetch") fetch=true; }
  var all=new List<string>();
  all.Add("-c"); all.Add("safe.directory="+cwd);
  if(transport) {
   if(!File.Exists(map)) return 91;
   if(push && File.Exists(Path.Combine(cwd,".git","fixture-fail-push")) && File.ReadAllText(Path.Combine(cwd,".git","fixture-fail-push")).Trim()=="fail") return 92;
   string remote=File.ReadAllText(map).Trim();
   if(!Path.IsPathRooted(remote)||!Directory.Exists(remote)) return 93;
   bool replaced=false;
   for(int i=0;i<args.Length;i++) { if(args[i]=="origin") {args[i]=remote; replaced=true;} }
   if(!replaced) return 94;
  }
  all.AddRange(args);
  if(fetch) all.Add("+refs/heads/*:refs/remotes/origin/*");
  var p=new Process();
  p.StartInfo=new ProcessStartInfo(@"REAL_GIT",String.Join(" ",all.ConvertAll(Q).ToArray()));
  p.StartInfo.UseShellExecute=false; p.StartInfo.CreateNoWindow=true;
  p.StartInfo.RedirectStandardOutput=true; p.StartInfo.RedirectStandardError=true;
  p.StartInfo.StandardOutputEncoding=new System.Text.UTF8Encoding(false);
  p.StartInfo.StandardErrorEncoding=new System.Text.UTF8Encoding(false);
  p.Start();
  var output=p.StandardOutput.ReadToEndAsync(); var error=p.StandardError.ReadToEndAsync();
  p.WaitForExit();
  Console.OutputEncoding=new System.Text.UTF8Encoding(false);
  Console.Write(output.Result); Console.Error.Write(error.Result);
  bool merge=false, abort=false;
  foreach(string a in args) {if(a=="merge") merge=true; if(a=="--abort") abort=true;}
  if(merge && !abort && p.ExitCode==0 && File.Exists(Path.Combine(cwd,".git","fixture-interrupt-merge"))) return 95;
  return p.ExitCode;
 }
}
'@
$AdapterSource=$AdapterSource.Replace('REAL_GIT',$GitLiteral)
Add-Type -TypeDefinition $AdapterSource -OutputAssembly (Join-Path $AdapterDirectory 'git.exe') -OutputType ConsoleApplication
$PreviousPath=$env:PATH
$env:PATH=$AdapterDirectory+';'+$env:PATH
$Counter=0
function Native([string]$Root,[string[]]$Arguments) {
    $PreviousPreference=$ErrorActionPreference
    try {
        $ErrorActionPreference='Continue'
        $Output=@(& $RealGit -c "safe.directory=$Root" -C $Root @Arguments 2>&1)
        $ExitCode=$LASTEXITCODE
    }
    finally {$ErrorActionPreference=$PreviousPreference}
    if ($ExitCode) { throw "Fixture setup Git failure ($($Arguments[0]))" }
    return ($Output -join "`n")
}
function Fixture([string]$Kind='aligned',[switch]$Dirty,[switch]$Conflict) {
    $script:Counter++
    $FixtureDirectory=Join-Path $RunRoot "case-$script:Counter"
    $Root=Join-Path $FixtureDirectory 'clone'; $Bare=Join-Path $FixtureDirectory 'remote.git'
    $null=New-Item -ItemType Directory -Path $Root
    $null=Native $Root @('init','-b','markei-season-02')
    $null=Native $Root @('config','user.name','GRM fixture')
    $null=Native $Root @('config','user.email','fixture@example.invalid')
    $null=Native $Root @('config','core.autocrlf','false')
    Write-Text (Join-Path $Root 'AGENTS.md') "# Synthetic fixture`n"
    Write-Text (Join-Path $Root 'documentation/GRM.md') "# Synthetic GRM`n"
    Write-Text (Join-Path $Root 'documentation/NS_COORDINATES.md') "RepositoryBranch: markei-season-02`n"
    Write-Text (Join-Path $Root '.gitignore') "ignored/`n"
    Write-Text (Join-Path $Root 'note.md') "# Base`n"
    $null=Native $Root @('add','--','AGENTS.md','documentation/GRM.md','documentation/NS_COORDINATES.md','.gitignore','note.md')
    $null=Native $Root @('commit','-m','fixture base')
    $Base=Native $Root @('rev-parse','HEAD')
    $null=Native $Root @('init','--bare',$Bare)
    $null=Native $Root @('remote','add','origin',$Bare)
    $null=Native $Root @('push','origin','markei-season-02')
    if ($Kind -in @('remote-ahead','diverged')) {
        if ($Conflict) {Write-Text (Join-Path $Root 'note.md') "# Remote`n"} else {Write-Text (Join-Path $Root 'remote.md') "# Remote`n"}
        $null=Native $Root @('add','--all')
        $null=Native $Root @('commit','-m','remote addition')
        $null=Native $Root @('push','origin','markei-season-02')
        $null=Native $Root @('checkout','-b','fixture-local',$Base)
        $null=Native $Root @('branch','-f','markei-season-02',$Base)
        $null=Native $Root @('checkout','markei-season-02')
    }
    if ($Kind -in @('local-ahead','diverged')) {
        if ($Conflict) {Write-Text (Join-Path $Root 'note.md') "# Local`n"} else {Write-Text (Join-Path $Root 'local.md') "# Local`n"}
        $null=Native $Root @('add','--all')
        $null=Native $Root @('commit','-m','local addition')
    }
    $null=Native $Root @('config','remote.origin.url','https://github.com/gus-i-gu/markei.git')
    Write-Text (Join-Path $Root '.git/fixture-remote') $Bare
    if ($Dirty) { Write-Text (Join-Path $Root 'note.md') "# Dirty`n" }
    Write-Text (Join-Path $Root 'ignored/large.bin') ('x' * 3000001)
    [pscustomobject]@{Root=$Root; Bare=$Bare; Base=$Base}
}
function Run-Procedure($Fixture,[string]$Id,[switch]$Execute,[string]$Strategy='Merge',
    [string[]]$Paths=@('note.md'),[string]$Refuse='', [scriptblock]$AtGate=$null) {
    $Prior=Get-Location
    $IgnoredBefore=Get-IgnoredEvidence $Fixture
    $script:Answers=$Paths; $script:Refusal=$Refuse; $script:GateAction=$AtGate
    $script:Gates=New-Object 'System.Collections.Generic.List[string]'
    $Captured=New-Object 'System.Collections.Generic.List[string]'
    function Write-Host([object]$Object) {$Captured.Add([string]$Object)}
    function Read-Host([string]$Prompt) {
        if ($Prompt.StartsWith('Exact reviewed paths')) { return ConvertTo-Json -InputObject @($script:Answers) -Compress }
        if ($Prompt.StartsWith('Commit message')) { return 'fixture reviewed publication' }
        if ($Prompt -match "^Type '(.*)' or STOP$") {
            $Expected=$Matches[1]; $script:Gates.Add($Expected)
            if ($script:GateAction) { & $script:GateAction $Expected }
            if ($script:Refusal -and $Expected.StartsWith($script:Refusal+' ')) {return 'STOP'}
            return $Expected
        }
        throw 'Unknown fixture prompt'
    }
    try {
        Set-Location -LiteralPath $Fixture.Root
        # Capture host and success streams without redirecting native stderr to
        # PowerShell's error stream: 5.1 treats successful Git pull diagnostics
        # as terminating errors when *>&1 is combined with ErrorAction=Stop.
        if ($Id -eq 'GS-GIT-03') { & (Get-GrmProcedure $Id) -Publish:$Execute | ForEach-Object {$Captured.Add([string]$_)} }
        else { & (Get-GrmProcedure $Id) -Execute:$Execute -Strategy $Strategy | ForEach-Object {$Captured.Add([string]$_)} }
        [pscustomobject]@{Stopped=$false; Text=($Captured -join "`n"); Gates=@($script:Gates.ToArray())}
    }
    catch { [pscustomobject]@{Stopped=$true; Text=(($Captured -join "`n")+"`n"+$_.Exception.Message); Gates=@($script:Gates.ToArray())} }
    finally {
        Set-Location -LiteralPath $Prior.Path
        Assert ((Get-IgnoredEvidence $Fixture) -ceq $IgnoredBefore) 'Ignored fixture bytes or metadata changed'
    }
}
function Get-IgnoredEvidence($Fixture) {
    return (@(Get-ChildItem -LiteralPath (Join-Path $Fixture.Root 'ignored') -Recurse -Force | Sort-Object FullName | ForEach-Object {
        $Payload=if($_.Attributes -band [IO.FileAttributes]::ReparsePoint){@($_.Target) -join "`0"}elseif($_.PSIsContainer){'directory'}else{(Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash}
        $_.FullName.Substring($Fixture.Root.Length)+':'+$Payload+':'+$_.Attributes+':'+$_.LastWriteTimeUtc.Ticks
    }) -join "`n")
}
function Snapshot($Fixture) {
    $Files=@(Get-ChildItem -LiteralPath $Fixture.Root -Recurse -Force -File | Where-Object {$_.FullName -notlike ($Fixture.Root+'\.git\*')} | Sort-Object FullName | ForEach-Object {
        $_.FullName.Substring($Fixture.Root.Length)+':'+(Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash+':'+$_.Attributes+':'+$_.LastWriteTimeUtc.Ticks
    })
    [pscustomobject]@{Head=(Native $Fixture.Root @('rev-parse','HEAD'));
        Index=(Native $Fixture.Root @('ls-files','--stage'));
        Files=($Files -join "`n"); Refs=(Native $Fixture.Root @('show-ref'));
        Remote=(Native $Fixture.Bare @('rev-parse','refs/heads/markei-season-02'))}
}
try {
    if ($Diagnostic) {
        $f=Fixture
        Set-Location -LiteralPath $f.Root
        . (Get-GrmGitSupport)
        Write-Output "Real=$RealGit Adapter=$Git03Exe Root=$Git03Root"
        Write-Output (Invoke-Git03 @('rev-parse','--show-toplevel'))
        Assert-Git03Repository
        Get-Git03State | Format-List
        Get-GitProtocolState | Format-List
        return
    }
    foreach ($Kind in @('aligned','remote-ahead','local-ahead','diverged')) {
        foreach ($Dirty in @($false,$true)) {
            Record "classification $Kind dirty=$Dirty" {
                $f=Fixture $Kind -Dirty:$Dirty; $Before=Snapshot $f
                $r=Run-Procedure $f 'GS-GIT-05'
                $Expected=$Kind+$(if($Dirty){'-dirty'}else{'-clean'})
                Assert ($r.Text.Contains($Expected)) "Classification missing: $($r.Text)"
                $After=Snapshot $f
                Assert ($Before.Head -ceq $After.Head -and $Before.Index -ceq $After.Index -and $Before.Files -ceq $After.Files -and $Before.Remote -ceq $After.Remote) 'Dry run mutated fixture'
            }
        }
    }
    foreach ($Guard in @('wrong-branch','detached','wrong-origin','lock','operation','assume','skip','hook','filter','shallow','replace')) {
        Record "guard $Guard" {
            $f=Fixture
            switch ($Guard) {
                wrong-branch {$null=Native $f.Root @('checkout','-b','wrong')}
                detached {$null=Native $f.Root @('checkout','--detach')}
                wrong-origin {$null=Native $f.Root @('config','remote.origin.url','https://example.invalid/wrong.git')}
                lock {Write-Text (Join-Path $f.Root '.git/index.lock') ''}
                operation {Write-Text (Join-Path $f.Root '.git/MERGE_HEAD') $f.Base}
                assume {$null=Native $f.Root @('update-index','--assume-unchanged','note.md')}
                skip {$null=Native $f.Root @('update-index','--skip-worktree','note.md')}
                hook {Write-Text (Join-Path $f.Root '.git/hooks/pre-commit') '# synthetic hook'}
                filter {$null=Native $f.Root @('config','filter.fixture.clean','synthetic')}
                shallow {Write-Text (Join-Path $f.Root '.git/shallow') ($f.Base+"`n")}
                replace {$null=Native $f.Root @('update-ref',('refs/replace/'+$f.Base),$f.Base)}
            }
            $Before=Snapshot $f; $r=Run-Procedure $f 'GS-GIT-05' -Execute
            Assert $r.Stopped 'Guard did not stop'
            $After=Snapshot $f
            Assert ($Before.Head -ceq $After.Head -and $Before.Index -ceq $After.Index -and $Before.Files -ceq $After.Files -and $Before.Remote -ceq $After.Remote) 'Guard changed fixture'
        }
    }
    foreach ($Path in @('note.md','documentation/space name.md','documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md')) {
        Record "normal publication $Path" {
            $f=Fixture; Write-Text (Join-Path $f.Root $Path) "# Reviewed`n"
            $r=Run-Procedure $f 'GS-GIT-03' -Execute -Paths @($Path)
            Assert (!$r.Stopped -and $r.Text.Contains('published-clean')) "Publication failed: $($r.Text)"
            Assert ((Native $f.Root @('rev-parse','HEAD')) -ceq (Native $f.Bare @('rev-parse','refs/heads/markei-season-02'))) 'Remote equality failure'
        }
    }
    foreach ($Gate in @('REVIEW','STAGE','COMMIT','PUSH')) {
        Record "refusal $Gate" {
            $f=Fixture -Dirty; $Before=Snapshot $f
            $r=Run-Procedure $f 'GS-GIT-03' -Execute -Refuse $Gate
            Assert ($r.Stopped -and $r.Text.Contains('confirmation refused')) "Refusal failure: $($r.Text)"
            $After=Snapshot $f; Assert ($Before.Files -ceq $After.Files -and $Before.Remote -ceq $After.Remote) 'Refusal changed bytes/remote'
            if ($Gate -in @('REVIEW','STAGE')) {Assert ($Before.Head -ceq $After.Head -and $Before.Index -ceq $After.Index) 'Early refusal mutated state'}
            if ($Gate -eq 'COMMIT') {Assert ($Before.Head -ceq $After.Head -and $Before.Index -cne $After.Index) 'Commit refusal staging boundary'}
            if ($Gate -eq 'PUSH') {Assert ($Before.Head -cne $After.Head) 'Push refusal did not retain commit'}
        }
    }
    Record 'outgoing-only retry' {
        $f=Fixture 'local-ahead'; $Before=Snapshot $f
        $r=Run-Procedure $f 'GS-GIT-03' -Execute -Paths @('local.md')
        Assert (!$r.Stopped) "Retry failed: $($r.Text)"
        $After=Snapshot $f; Assert ($Before.Head -ceq $After.Head -and $After.Head -ceq $After.Remote) 'Retry created commit or failed equality'
    }
    Record 'failed push retains local commit' {
        $f=Fixture -Dirty; $Before=Snapshot $f
        Write-Text (Join-Path $f.Root '.git/fixture-fail-push') 'fail'
        $r=Run-Procedure $f 'GS-GIT-03' -Execute; $After=Snapshot $f
        Assert ($r.Stopped -and $r.Text.Contains('Git push failed') -and $Before.Remote -ceq $After.Remote -and $Before.Head -cne $After.Head) 'Failed push boundary mismatch'
    }
    foreach ($Strategy in @('Merge','Rebase')) {
        Record "reconciliation $Strategy" {
            $f=Fixture 'diverged'; $Before=Snapshot $f
            $r=Run-Procedure $f 'GS-GIT-04' -Execute -Strategy $Strategy
            Assert (!$r.Stopped -and $r.Text.Contains('local-ahead-clean')) "Reconciliation failed: $($r.Text)"
            $After=Snapshot $f; Assert ($Before.Remote -ceq $After.Remote) 'GIT04 published'
            Assert ((Native $f.Root @('for-each-ref','--format=%(refname)','refs/markei-safety/')).Split("`n").Count -eq 3) 'Missing safety refs'
        }
    }
    foreach ($Case in @('duplicate','staging-outside','rename-missing-endpoint','unsupported-type','unicode','leading-dash','arbitrary-bracket')) {
        Record "exact path STOP $Case" {
            $f=Fixture -Dirty; $Paths=@('note.md'); $Expected='STOP:'
            switch ($Case) {
                duplicate {$Paths=@('note.md','note.md'); $Expected='duplicate paths'}
                staging-outside {Write-Text (Join-Path $f.Root 'outside.md') "# Outside`n"; $null=Native $f.Root @('add','--','outside.md'); $Expected='pre-existing staging'}
                rename-missing-endpoint {$null=Native $f.Root @('mv','note.md','renamed.md'); $Paths=@('renamed.md'); $Expected='pre-existing staging'}
                unsupported-type {Write-Text (Join-Path $f.Root 'sample.dart') 'void main() {}'; $Paths=@('sample.dart'); $Expected='no supported non-writing validator'}
                unicode {$UnicodePath='caf'+[char]0xe9+'.md'; Write-Text (Join-Path $f.Root $UnicodePath) "# Unicode`n"; $Paths=@($UnicodePath); $Expected='publication path policy'}
                leading-dash {Write-Text (Join-Path $f.Root '-dash.md') "# Dash`n"; $Paths=@('-dash.md'); $Expected='publication path policy'}
                arbitrary-bracket {Write-Text (Join-Path $f.Root 'other/[X]/note.md') "# Bracket`n"; $Paths=@('other/[X]/note.md'); $Expected='publication path policy'}
            }
            $Before=Snapshot $f; $r=Run-Procedure $f 'GS-GIT-03' -Execute -Paths $Paths; $After=Snapshot $f
            Assert ($r.Stopped -and $r.Text.Contains($Expected)) "Wrong path STOP: $($r.Text)"
            Assert ($Before.Head -ceq $After.Head -and $Before.Index -ceq $After.Index -and $Before.Files -ceq $After.Files -and $Before.Remote -ceq $After.Remote) 'Path STOP changed fixture'
        }
    }
    foreach ($Case in @('deletion','rename','pre-staged','residue')) {
        Record "exact path publication $Case" {
            $f=Fixture -Dirty; $Paths=@('note.md')
            switch ($Case) {
                deletion {$null=Native $f.Root @('rm','--force','--','note.md')}
                rename {$null=Native $f.Root @('mv','note.md','renamed.md'); $Paths=@('note.md','renamed.md')}
                pre-staged {$null=Native $f.Root @('add','--','note.md')}
                residue {Write-Text (Join-Path $f.Root 'unselected.md') "# Unselected`n"}
            }
            $Before=Snapshot $f; $r=Run-Procedure $f 'GS-GIT-03' -Execute -Paths $Paths; $After=Snapshot $f
            Assert (!$r.Stopped -and $r.Text.Contains('published-')) "Path publication failed: $($r.Text)"
            Assert ($After.Head -ceq $After.Remote -and $Before.Files -ceq $After.Files) 'Publication changed worktree bytes/metadata'
            if ($Case -eq 'residue') {Assert ($r.Text.Contains('published-with-local-changes')) 'Residue classification missing'}
        }
    }
    foreach ($Kind in @('aligned','remote-ahead','local-ahead','diverged')) {
        Record "GIT05 delegation $Kind" {
            $f=Fixture $Kind -Dirty:($Kind -eq 'aligned')
            $Paths=if($Kind -eq 'local-ahead'){@('local.md')}elseif($Kind -eq 'diverged'){@('local.md','remote.md')}else{@('note.md')}
            $r=Run-Procedure $f 'GS-GIT-05' -Execute -Paths $Paths
            Assert (!$r.Stopped -and $r.Text.Contains('PASS: aligned-clean')) "Delegation failed: $($r.Text)"
            $After=Snapshot $f; Assert ($After.Head -ceq $After.Remote) 'Delegated equality failure'
            Assert (!(Native $f.Root @('status','--porcelain'))) 'Delegated ordinary residue'
        }
    }
    foreach ($Strategy in @('Merge','Rebase')) {
        foreach ($Gate in $(if($Strategy -eq 'Merge'){@('EXCLUSIVE','MERGE','MERGE-COMMIT')}else{@('EXCLUSIVE','REBASE-UNPUBLISHED','REBASE')})) {
            Record "GIT04 refusal $Strategy $Gate" {
                $f=Fixture 'diverged'; $Before=Snapshot $f
                $r=Run-Procedure $f 'GS-GIT-04' -Execute -Strategy $Strategy -Refuse $Gate; $After=Snapshot $f
                Assert ($r.Stopped -and $r.Text.Contains('confirmation refused') -and $Before.Head -ceq $After.Head -and $Before.Remote -ceq $After.Remote) 'Reconciliation refusal boundary'
                if ($Gate -ne 'MERGE-COMMIT') {Assert ($Before.Files -ceq $After.Files -and $Before.Index -ceq $After.Index) 'Pre-integration refusal mutated files'}
                else {Assert ((Native $f.Root @('rev-parse','MERGE_HEAD')) -ceq $Before.Remote) 'Refused merge commit lost merge state'}
            }
        }
    }
    Record 'predicted merge conflict' {
        $f=Fixture 'diverged' -Conflict; $Before=Snapshot $f
        $r=Run-Procedure $f 'GS-GIT-04' -Execute; $After=Snapshot $f
        Assert ($r.Stopped -and $r.Text.Contains('predicted merge conflict')) "Conflict prediction failed: $($r.Text)"
        Assert ($Before.Head -ceq $After.Head -and $Before.Index -ceq $After.Index -and $Before.Files -ceq $After.Files -and $Before.Refs -ceq $After.Refs) 'Prediction changed principal state'
    }
    Record 'actual rebase conflict and verified abort' {
        $f=Fixture 'diverged' -Conflict; $Before=Snapshot $f
        $r=Run-Procedure $f 'GS-GIT-04' -Execute -Strategy Rebase; $After=Snapshot $f
        Assert ($r.Stopped -and $r.Text.Contains('original HEAD, file bytes and logical index verified')) "Abort failed: $($r.Text)"
        Assert ($Before.Head -ceq $After.Head -and $Before.Index -ceq $After.Index) 'Rebase abort logical boundary'
        Assert ((Native $f.Root @('for-each-ref','--format=%(refname)','refs/markei-safety/')).Split("`n").Count -eq 3) 'Abort safety refs absent'
    }
    Record 'published local commit refuses rebase' {
        $f=Fixture 'diverged'; $Head=Native $f.Root @('rev-parse','HEAD')
        $null=Native $f.Root @('push',$f.Bare,'HEAD:refs/heads/certification-visible')
        $r=Run-Procedure $f 'GS-GIT-04' -Execute -Strategy Rebase
        Assert ($r.Stopped -and $r.Text.Contains('reachable from remote ref') -and (Native $f.Root @('rev-parse','HEAD')) -ceq $Head) 'Published rebase refusal failed'
    }
    Record 'merge plus following commit failed-push retry' {
        $f=Fixture 'diverged'
        $r=Run-Procedure $f 'GS-GIT-04' -Execute
        Assert (!$r.Stopped) 'Fixture merge failed'
        Write-Text (Join-Path $f.Root 'note.md') "# Following merge`n"
        Write-Text (Join-Path $f.Root '.git/fixture-fail-push') 'fail'
        $r=Run-Procedure $f 'GS-GIT-03' -Execute -Paths @('local.md','remote.md','note.md')
        Assert ($r.Stopped -and $r.Text.Contains('Git push failed')) "Expected push failure missing: $($r.Text)"
        $Before=Snapshot $f
        Write-Text (Join-Path $f.Root '.git/fixture-fail-push') 'pass'
        $r=Run-Procedure $f 'GS-GIT-03' -Execute -Paths @('local.md','remote.md','note.md')
        Assert (!$r.Stopped) "Retry of production-created lineage failed: $($r.Text)"
        $After=Snapshot $f; Assert ($Before.Head -ceq $After.Head -and $After.Head -ceq $After.Remote) 'Merge retry created commit or failed equality'
    }
    foreach ($Gate in @('STAGE','COMMIT','PUSH')) {
        Record "concurrent selected bytes $Gate" {
            $f=Fixture -Dirty
            $r=Run-Procedure $f 'GS-GIT-03' -Execute -AtGate {
                param($Expected)
                if ($Expected.StartsWith($Gate+' ')) {Write-Text (Join-Path $f.Root 'note.md') "# Concurrent changed`n"}
            }
            Assert ($r.Stopped -and $r.Text.Contains('changed')) "Concurrent change was not stopped: $($r.Text)"
            Assert ((Native $f.Bare @('rev-parse','refs/heads/markei-season-02')) -ceq $f.Base) 'Race published'
        }
    }
    foreach ($Gate in @('REVIEW','STAGE','COMMIT','PUSH')) {
        Record "remote movement $Gate" {
            $f=Fixture -Dirty
            $r=Run-Procedure $f 'GS-GIT-03' -Execute -AtGate {
                param($Expected)
                if ($Expected.StartsWith($Gate+' ')) {
                    $null=Native $f.Bare @('update-ref','refs/heads/markei-season-02',$f.Base) # replace below with a distinct existing fixture object
                    $null=Native $f.Root @('push',$f.Bare,'HEAD:refs/heads/fixture-object')
                    $Candidate=Native $f.Root @('rev-parse','HEAD')
                    if ($Candidate -ceq $f.Base) {
                        $Tree=Native $f.Root @('rev-parse','HEAD^{tree}')
                        $Candidate=Native $f.Root @('commit-tree',$Tree,'-p',$f.Base,'-m','remote movement fixture')
                        $null=Native $f.Root @('push',$f.Bare,($Candidate+':refs/heads/markei-season-02'))
                    } else { $null=Native $f.Bare @('update-ref','refs/heads/markei-season-02',$Candidate) }
                }
            }
            Assert ($r.Stopped -and $r.Text.Contains('remote moved')) "Remote movement was not stopped: $($r.Text)"
        }
    }
    Record 'supported ignored symbolic link preservation' {
        $f=Fixture 'diverged'
        $LinkPath=Join-Path $f.Root 'ignored/synthetic-link'
        $Target=Join-Path $f.Root 'ignored/large.bin'
        $null=New-Item -ItemType SymbolicLink -Path $LinkPath -Target $Target
        $Before=Get-Item -LiteralPath $LinkPath -Force
        $BeforeTarget=@($Before.Target) -join "`0"
        $BeforeAttributes=$Before.Attributes; $BeforeTicks=$Before.LastWriteTimeUtc.Ticks
        $r=Run-Procedure $f 'GS-GIT-04' -Execute
        Assert (!$r.Stopped) "Supported link reconciliation failed: $($r.Text)"
        $After=Get-Item -LiteralPath $LinkPath -Force
        Assert ((@($After.Target) -join "`0") -ceq $BeforeTarget -and $After.Attributes -eq $BeforeAttributes -and $After.LastWriteTimeUtc.Ticks -eq $BeforeTicks) 'Ignored link metadata changed'
    }
    Record 'historical exact revision blob and forms' {
        Set-Location -LiteralPath $SourceRoot
        . (Get-GrmGitSupport)
        $Revision='8143e4bde109427d63670057cd6612b89292474e'
        $Path='documentation/G_SCRIPTS.md'
        $HistoricalText=Invoke-Git03 @('show',($Revision+':'+$Path))
        Assert-Git03HistoricalDocument $Revision $Path $HistoricalText
        Assert-Git03HistoricalDocument 'INDEX' $Path $HistoricalText
        foreach ($Variant in @('different-source','different-bytes','different-path','different-forms')) {
            $Stopped=$false
            try {
                switch ($Variant) {
                    different-source {Assert-Git03HistoricalDocument ((Invoke-Git03 @('rev-parse','HEAD^')).Trim()) $Path $HistoricalText}
                    different-bytes {Assert-Git03HistoricalDocument $Revision $Path ($HistoricalText+"`n")}
                    different-path {Assert-Git03HistoricalDocument $Revision 'documentation/GRM.md' $HistoricalText}
                    different-forms {Assert-Git03HistoricalDocument $Revision $Path ($HistoricalText.Replace('-Action <action>','-Action different'))}
                }
            } catch {$Stopped=$true}
            Assert $Stopped "Historical exception widened: $Variant"
        }
    }
    Record 'existing conflicts classify STOP' {
        $f=Fixture 'diverged' -Conflict
        try {$null=Native $f.Root @('merge','--no-commit','refs/remotes/origin/markei-season-02')} catch {}
        $Before=Snapshot $f; $r=Run-Procedure $f 'GS-GIT-05' -Execute; $After=Snapshot $f
        Assert ($r.Stopped -and $r.Text.Contains('conflicted')) "Conflict classification failed: $($r.Text)"
        Assert ($Before.Head -ceq $After.Head -and $Before.Index -ceq $After.Index -and $Before.Files -ceq $After.Files) 'Existing conflicts changed'
    }
    foreach ($Case in @('octopus','additional-merge','wrong-second-parent')) {
        Record "unsupported outgoing topology $Case" {
            $f=Fixture 'local-ahead'; $Head=Native $f.Root @('rev-parse','HEAD'); $Tree=Native $f.Root @('rev-parse','HEAD^{tree}')
            $Side1=Native $f.Root @('commit-tree',$Tree,'-p',$f.Base,'-m','synthetic side 1')
            $Side2=Native $f.Root @('commit-tree',$Tree,'-p',$f.Base,'-m','synthetic side 2')
            switch ($Case) {
                octopus {$Next=Native $f.Root @('commit-tree',$Tree,'-p',$Head,'-p',$Side1,'-p',$Side2,'-m','synthetic octopus')}
                additional-merge {
                    $First=Native $f.Root @('commit-tree',$Tree,'-p',$Head,'-p',$Side1,'-m','synthetic merge 1')
                    $Next=Native $f.Root @('commit-tree',$Tree,'-p',$First,'-p',$Side2,'-m','synthetic merge 2')
                }
                wrong-second-parent {$Next=Native $f.Root @('commit-tree',$Tree,'-p',$Head,'-p',$Side1,'-m','synthetic wrong remote parent')}
            }
            $null=Native $f.Root @('update-ref','refs/heads/markei-season-02',$Next)
            $Before=Snapshot $f; $r=Run-Procedure $f 'GS-GIT-03' -Execute -Paths @('local.md'); $After=Snapshot $f
            Assert ($r.Stopped -and $r.Text -match 'unsupported|lineage') "Topology STOP missing: $($r.Text)"
            Assert ($Before.Head -ceq $After.Head -and $Before.Index -ceq $After.Index -and $Before.Files -ceq $After.Files -and $Before.Remote -ceq $After.Remote) 'Topology STOP changed state'
        }
    }
    Record 'fault-injected merge interruption verified abort' {
        $f=Fixture 'diverged'; $Before=Snapshot $f
        Write-Text (Join-Path $f.Root '.git/fixture-interrupt-merge') 'interrupt after Git merge result'
        $r=Run-Procedure $f 'GS-GIT-04' -Execute; $After=Snapshot $f
        Assert ($r.Stopped -and $r.Text.Contains('original HEAD, file bytes and logical index verified')) "Owned interruption abort failed: $($r.Text)"
        Assert ($Before.Head -ceq $After.Head -and $Before.Index -ceq $After.Index -and $Before.Remote -ceq $After.Remote) 'Interrupted merge boundary differs'
        Assert (!(Test-Path -LiteralPath (Join-Path $f.Root '.git/MERGE_HEAD'))) 'Interrupted merge left active operation'
        Assert ((Native $f.Root @('for-each-ref','--format=%(refname)','refs/markei-safety/')).Split("`n").Count -eq 3) 'Interrupted merge lost safety refs'
    }
    foreach ($Gate in @('FAST-FORWARD','PUBLISH')) {
        Record "GIT05 transition refusal $Gate" {
            $Kind=if($Gate -eq 'FAST-FORWARD'){'remote-ahead'}else{'local-ahead'}
            $f=Fixture $Kind; $Before=Snapshot $f
            $r=Run-Procedure $f 'GS-GIT-05' -Execute -Paths @('local.md') -Refuse $Gate; $After=Snapshot $f
            Assert ($r.Stopped -and $r.Text.Contains('confirmation refused')) 'Orchestration approval not independent'
            Assert ($Before.Head -ceq $After.Head -and $Before.Index -ceq $After.Index -and $Before.Files -ceq $After.Files -and $Before.Remote -ceq $After.Remote) 'Transition refusal mutated state'
        }
    }
    foreach ($Strategy in @('Merge','Rebase')) {
        foreach ($Gate in $(if($Strategy -eq 'Merge'){@('EXCLUSIVE','MERGE','MERGE-COMMIT')}else{@('EXCLUSIVE','REBASE-UNPUBLISHED','REBASE')})) {
            Record "GIT04 concurrent files $Strategy $Gate" {
                $f=Fixture 'diverged'
                $r=Run-Procedure $f 'GS-GIT-04' -Execute -Strategy $Strategy -AtGate {
                    param($Expected)
                    if ($Expected.StartsWith($Gate+' ')) {Write-Text (Join-Path $f.Root 'concurrent.md') "# Concurrent file`n"}
                }
                Assert ($r.Stopped -and $r.Text.Contains('changed')) "Concurrent reconciliation gate missed: $($r.Text)"
                Assert ((Native $f.Bare @('rev-parse','refs/heads/markei-season-02')) -ceq (Native $f.Root @('rev-parse','refs/remotes/origin/markei-season-02'))) 'Concurrent reconciliation published'
            }
        }
    }
    foreach ($Gate in @('FAST-FORWARD','PUBLISH','REVIEW','HISTORY','MERGE-HISTORY')) {
        Record "concurrent file gate $Gate" {
            $Kind=if($Gate -eq 'FAST-FORWARD'){'remote-ahead'}elseif($Gate -in @('PUBLISH','HISTORY')){'local-ahead'}elseif($Gate -eq 'MERGE-HISTORY'){'diverged'}else{'aligned'}
            $f=Fixture $Kind -Dirty:($Gate -eq 'REVIEW')
            if ($Gate -eq 'MERGE-HISTORY') {$r=Run-Procedure $f 'GS-GIT-04' -Execute; Assert (!$r.Stopped) 'Gate fixture merge failed'}
            $Paths=if($Gate -eq 'MERGE-HISTORY'){@('local.md','remote.md')}elseif($Kind -eq 'local-ahead'){@('local.md')}else{@('note.md')}
            $Id=if($Gate -in @('FAST-FORWARD','PUBLISH')){'GS-GIT-05'}else{'GS-GIT-03'}
            $r=Run-Procedure $f $Id -Execute -Paths $Paths -AtGate {
                param($Expected)
                if ($Expected.StartsWith($Gate+' ')) {Write-Text (Join-Path $f.Root 'concurrent.md') "# Concurrent file`n"}
            }
            Assert ($r.Stopped -and $r.Text.Contains('changed')) "Concurrent gate missed: $($r.Text)"
        }
    }
    foreach ($Strategy in @('Merge','Rebase')) {
        foreach ($Gate in $(if($Strategy -eq 'Merge'){@('EXCLUSIVE','MERGE','MERGE-COMMIT')}else{@('EXCLUSIVE','REBASE-UNPUBLISHED','REBASE')})) {
            Record "GIT04 remote movement $Strategy $Gate" {
                $f=Fixture 'diverged'
                $r=Run-Procedure $f 'GS-GIT-04' -Execute -Strategy $Strategy -AtGate {
                    param($Expected)
                    if ($Expected.StartsWith($Gate+' ')) {
                        $Remote=Native $f.Bare @('rev-parse','refs/heads/markei-season-02')
                        $Tree=Native $f.Root @('rev-parse',($Remote+'^{tree}'))
                        $Moved=Native $f.Root @('commit-tree',$Tree,'-p',$Remote,'-m','synthetic remote race')
                        $null=Native $f.Root @('push',$f.Bare,($Moved+':refs/heads/markei-season-02'))
                    }
                }
                Assert ($r.Stopped -and $r.Text.Contains('changed')) "Reconciliation remote gate missed: $($r.Text)"
            }
        }
    }
    foreach ($Gate in @('HISTORY','MERGE-HISTORY','FAST-FORWARD','PUBLISH')) {
        Record "remaining remote gate $Gate" {
            $Kind=if($Gate -eq 'FAST-FORWARD'){'remote-ahead'}elseif($Gate -eq 'MERGE-HISTORY'){'diverged'}else{'local-ahead'}
            $f=Fixture $Kind
            if ($Gate -eq 'MERGE-HISTORY') {$r=Run-Procedure $f 'GS-GIT-04' -Execute; Assert (!$r.Stopped) 'Fixture merge failed'}
            $Paths=if($Gate -eq 'MERGE-HISTORY'){@('local.md','remote.md')}else{@('local.md')}
            $Id=if($Gate -in @('FAST-FORWARD','PUBLISH')){'GS-GIT-05'}else{'GS-GIT-03'}
            $r=Run-Procedure $f $Id -Execute -Paths $Paths -AtGate {
                param($Expected)
                if ($Expected.StartsWith($Gate+' ')) {
                    $Remote=Native $f.Bare @('rev-parse','refs/heads/markei-season-02')
                    $Tree=Native $f.Root @('rev-parse',($Remote+'^{tree}'))
                    $Moved=Native $f.Root @('commit-tree',$Tree,'-p',$Remote,'-m','synthetic remote race')
                    $null=Native $f.Root @('push',$f.Bare,($Moved+':refs/heads/markei-season-02'))
                }
            }
            Assert ($r.Stopped -and $r.Text -match 'remote moved|tips.*changed') "Remote gate missed: $($r.Text)"
        }
    }
    Record 'synthetic secret suppression' {
        $f=Fixture; $Marker='ghp_'+('A'*30)
        Write-Text (Join-Path $f.Root 'note.md') ($Marker+"`n")
        $Before=Snapshot $f; $r=Run-Procedure $f 'GS-GIT-03' -Execute; $After=Snapshot $f
        Assert ($r.Stopped -and !$r.Text.Contains($Marker) -and $Before.Head -ceq $After.Head -and $Before.Index -ceq $After.Index) 'Secret suppression boundary failed'
    }
}
finally {$env:PATH=$PreviousPath; Set-Location -LiteralPath $SourceRoot}
$Results | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $RunRoot 'results.json') -Encoding UTF8
$Results | Format-Table -AutoSize
Write-Output "Evidence: $RunRoot"
if (@($Results | Where-Object {$_.Result -eq 'FAIL'}).Count) {throw 'Acceptance harness failures; see structured results.'}
