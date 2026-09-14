# Flutter Template

Flutter Template is a reference Flutter application that demonstrates a small, production-ready feature shape without encoding a specific product domain.

## Language

**Application Preference**:
A persisted choice that controls application presentation or behavior for a device, such as theme mode or locale.
_Avoid_: Setting, flag

**Destination**:
A named place in the application that has a path and may participate in the primary tab navigation.
_Avoid_: Screen, page, route

**Feature Slice**:
The complete application-specific behavior for one capability, from presentation through its domain model to an adapter when one is justified.
_Avoid_: Example feature, vertical slice

**Application Presentation State**:
The observable theme mode and locale derived from Application Preferences for rendering the application.
_Avoid_: Global settings, UI flags

**Destination Catalog**:
The ordered set of Destination definitions that supplies both navigation policy and primary-navigation presentation.
_Avoid_: Route list, tab configuration
