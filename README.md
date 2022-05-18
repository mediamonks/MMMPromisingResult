# MMMPromisingResult

[![Build](https://github.com/mediamonks/MMMPromisingResult/workflows/Build/badge.svg)](https://github.com/mediamonks/MMMPromisingResult/actions?query=workflow%3ABuild)
[![Test](https://github.com/mediamonks/MMMPromisingResult/workflows/Test/badge.svg)](https://github.com/mediamonks/MMMPromisingResult/actions?query=workflow%3ATest)

A simple promising response for async operations.

(This is a part of `MMMTemple` suite of iOS libraries we use at [MediaMonks](https://www.mediamonks.com/).)

## Installation

Podfile:

```ruby
source 'https://github.com/mediamonks/MMMSpecs.git'
source 'https://cdn.cocoapods.org/'
...
pod 'MMMPromisingResult'
```

SPM:

```swift
.package(url: "https://github.com/mediamonks/MMMPromisingResult", .upToNextMajor(from: "0.1.0"))
```

## Usage

A promise-like type using `Swift.Result` as its value. This part is to be seen by the user code,
the one that is interested in consumption or transformation of the result, not providing it.

You cannot initialize it directly, see `PromisingResultSink` for the part where the value can 
be pushed to.

> **Note:** You must keep a reference to this object or the corresponding callback chain will 
> be cancelled.

### Example

```swift
// Some method that downloads a `URL` and promises to return `Data`.
func download(url: URL) -> Promising<Data> {
	
	// We open up a sink, we can push results to this.
	let sink = PromisingResultSink<Data, Error>()
	
	// Do some sort of async task.
	let request = URLSession.shared.dataTask(with: url) { data, response, err in
		
		if let data = data {
			// We succeeded in our async operation.
			sink.push(.success(data))
		} else {
			// We failed
			sink.push(.failure(err ?? MyError.noData))
		}
	}
	
	request.resume()
	
	// The `drain` is the user-end of the PromisingResultSink, this is what you would
	// expose to users of your class / framework etc.
	return sink.drain
}

// We have to store the promising result, when it's released it will stop listening.
private var downloadRequest: Promising<Data>?

func executeDownload() {
	
	let url = URL(string: "https://google.com")!
	
	// As mentioned above, we store the request, but attach a completion handler first.
	// Have a look at the documentation for more methods on `PromisingResult`.
	downloadRequest = download(url: url).completion { result in
		switch result {
		case .failure(let err):
			print("Received error: \(err)")
		case .success(let data):
			print("Received data: \(data)")
		}
	}
}
```

## Ready for liftoff? 🚀

We're always looking for talent. Join one of the fastest-growing rocket ships in
the business. Head over to our [careers page](https://media.monks.com/careers)
for more info!
