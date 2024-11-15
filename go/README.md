## A simple AWS Lambda in Go

## Build
**Important:** If building on an arm-based Mac, make sure to use the correct build configuration:

```
GOOS=linux GOARCH=amd64 go build -o bootstrap main.go
```