package main

import (
	"context"
	"fmt"
	"github.com/aws/aws-lambda-go/lambda"
)

type Response struct {
	Message string `json:"message"`
}

func HandleRequest(ctx context.Context, event interface{}) (Response, error) {
	fmt.Println("event", event)

	return Response{Message: "Hello world!"}, nil
}

func main() {
	lambda.Start(HandleRequest)
}
