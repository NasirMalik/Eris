# Eris

Architecture is devided in the following independly injectable and testable layers. 

## iOS-Architecture Reference 

Layers are defined here. 

### Coordinator
    Application Screenflow and later Push Routing handling
### View
    Display of data. Data is being displayed in the form of Models and views confrom to ModelConfigurable
### ViewController
    Controller contains logic of view's state representation
### ViewModel
    #### Mapper
        Mapper are the Domain Usecases. Any domain logic will be injected in the form of independently tested usecases. Idea is to keep Domain-Layer independent from ViewModels thus can be widely reuseable.
### Repository
    Its layer between ViewModel and Data Store that encapuslates Data-source layer. 
### Interactor
    #### Network
        Its a wrapper written as a Swift Package Ceres and fetch and decode data from internet. 
### Persistor
    #### CoreData
        Persistor encapsulates CoreData and fetches and updates data.
        
## Considerations

Following are few considerations while writing code
- Code should be CLEAN
- Every layer should be interfaced via dependency management and lays foundation for some high level DI-Framework
- Code should be testable and mocks can easily replace original objects
- Code is following iOS Swift Style Guidelines and have same styling throughtout the code. 
- DataStore and ViewModels are encapsulated from each other. 
        
