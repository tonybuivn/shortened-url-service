# Brief

ShortLink is a URL shortening service where you enter a URL such as https://codesubmit.io/library/react and it returns a short URL such as http://short.est/GeAi9K.

# Installation
### 1. Start Rails server
```
$ rails s
```

### 2. Start React frontend
```
$ cd frontend
$ npm start
```
Then access `localhost:4000` to start using shorten URL service

# My TODO list
- [x] Create 2 endpoints
  - [x] /encode - Encodes a URL to a shortened URL
  - [x] /decode - Decodes a shortened URL to its original URL.
  - [x] Both endpoints should return JSON
  - [x] Create React UI for this service
- [x] Decode previously encoded URLs after a restart
  - [x] Click to the shortened link to restore original link
- [ ] Provide tests for both endpoints (and any other tests you may want to write)
  - [x] Model test
  - [ ] Controller test
- [ ] (React) Handle validation
- (Optional) React part
  - [ ] Add loading button in shorten and decode button


- [ ] Provide detailed instructions on how to run your assignment in a separate markdown file
- [ ] Think through potential attack vectors on the application, and document them in the README
- [ ] Think through how your implementation may scale up, and document your approach in the README

