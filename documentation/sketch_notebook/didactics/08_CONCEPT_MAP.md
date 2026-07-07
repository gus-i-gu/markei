# Concept Map

```text
Python import system
    -> module namespace
    -> exported symbol
    -> class declaration

ImportError
    -> module found but symbol missing

ModuleNotFoundError
    -> module path not found

Repository Pattern
    -> service layer
    -> persistence layer
    -> RepositoryContract
    -> concrete implementation

ProductService
    -> depends on Repository-compatible object
    -> should not know SQL

Repository
    -> implements RepositoryContract
    -> owns SQL operations
    -> maps sqlite3 rows to domain models
```

```text
Python dictionary
    -> key
    -> value
    -> direct lookup
    -> safe lookup
    -> KeyError

KeyError
    -> runtime exception
    -> stack trace
    -> missing key

StoragePage initialization
    -> service-to-UI contract
    -> product display data
    -> presentation metadata

ProductService
    -> business data
    -> price variation semantics

StoragePage
    -> presentation data
    -> maps semantic data to visual style

PySide6 / Shiboken
    -> Python-to-C++ type conversion
    -> warning may be separate from Python exception
```
