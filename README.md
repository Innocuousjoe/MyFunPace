# A Simple Pedometer

## Usage
This is a straightforward, plug and play Pedometer that shows your step count over the last 7 days or, lacking that, some mocked data.

Load the app through Xcode using your preferred target, or by going to the external testing link [here](https://testflight.apple.com/join/DvNAC9Pe).

Clicking on any given day will bring you to a detailed view that will show you how close you were to hitting the recommended 10,000 steps per day, as well as a bit more information on how your day went.

## Architecture
Built on top of a straight forward MVVM architecture, this app uses a collection view with a diffable data source for the summary, and a simple UI (labels, some colorful UIBezierPath animations) for the detail view.

While some might argue this is wildly over-engineered (it is), it was designed in a way to allow considerable improvements without having to change the underlying code all that much; things like active updates (see [Roadmap](#Roadmap)) become much easier with a diffable data source.

## Third Party Libraries
SnapKit: plug and play DSL for `NSLayoutConstraint`


# Roadmap
## User Facing
1. iPad support
2. Active updates - show step count change while app is open
3. Support dark mode
4. Support landscape

## Internal
1. Add generator for mocks
2. Remove test dependency on production code (injectable mocks, or something along those lines)
3. UI Tests