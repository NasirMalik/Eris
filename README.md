# Eris

Name `Eris` is inspired from [here](https://solarsystem.nasa.gov/planets/dwarf-planets/eris)

## Architecture

Architecture is divided in the following independently injectable and testable layers.  Layers are defined here. 

### Coordinator
    Application Screenflow and later Push Routing handler.
### View
    Display of data. Data is being displayed in the form of Models and views confrom to ModelConfigurable to populate data via `configure(model:)` method
### ViewController
    Controller contains logic of view's state representation and pass actions to viewModel
### ViewModel
    - ViewModel does all the business logic implementation with or without help of mappers.
    - Also it informs view-controller about the state update via bindings. 
    - Mapper are the Domain Usecases. Any domain logic will be injected in the form of independently tested usecases. Idea is to keep Domain-Layer independent from ViewModels thus can be widely reuseable. Current implementation doesn't contain any domain logic thus doesn't contain any mapper.
### Repository
    Its an abstraction layer between ViewModel and Data Stores that encapuslates Data-source layer. Currently there are two data sources, Network and CoreData. This layer can encapulate further data sources aswel i-e Remote Configurations etc
### Interactor
    Network: Its a wrapper written on top of Swift Package `Ceres` which fetch and decode data into inferred model object. 
### Persistor
    CoreData: Persistor encapsulates CoreData and fetches and updates data.
        
## Considerations

Following are few considerations while writing code

- Code is following `MVVM-C` Architecture. 
- Every layer is interfaced via `dependency management` and lays foundation for high level DI-Framework
- Code is `testable` and mocks can easily replaced with original objects
- Code is following `iOS Swift Style Guidelines` and have same styling throughtout the code. 
- Project is structured to `scale` as big as it can be 
- `Folder structure` is highligting the architecture   
- Network is implemented as an independent `Module (Swift Package)`
- Layers are interfaced together via `Protocols`
- Dependency resolution is being done via Factory. 

## Testing Notes
- `NWPath.Status` doesn't return `.satisfied` on simulator so for getting best results please test on device.
