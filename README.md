# iKartta *WIP*

This project is built on Swift and SwifttUI using XCode.

## Local setup

Clone the project, `cd` into root directory and run:

```bash
$ pod install
```

This will install the project dependencies.

Open the `.xcworkspace` to open the project on XCode.

## Debug

Copy the `.env.example` file and fill the required fields.

The build phase runs a bash script and uses Sourcery to generate Swift code that contains the env variables in a usable struct.
