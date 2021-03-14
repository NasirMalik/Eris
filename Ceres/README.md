# Ceres

Name `Ceres` is inspired from [here](https://solarsystem.nasa.gov/planets/dwarf-planets/ceres)

## Network Layer Module
Network layer module shows how small, independently testable modules using SPM can be a great idea to moduleraize applicaitions. 

Some considerations are

- Reuseability
- Maintainability
- Testability
- Extendability
- Cohesion

## Structure
- NetworkService Infers `ModelAPI` for generating its object
- Request method infers `Model` object and decode object into `Model`

## Usage
`NetworkService` API should infer to `EndPointType`
Request method should infer to `Model: Decodable`

## Codeables Support
-Ceres works with decodeable model inference. 

## Disclaimar
- This Module was just created to demonstrate lighweight testable component based architecture, thus not endorsed for real usage as it lacks Queue based architecture and may not be able to scale well. 

## Cedits
https://medium.com/flawless-app-stories/writing-network-layer-in-swift-protocol-oriented-approach-4fa40ef1f908
