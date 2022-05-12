import React, { useState } from 'react'
import { BrowserRouter } from 'react-router-dom'
import { useDispatch, useSelector } from 'react-redux'
import {
  Container,
  Form,
  FormControl,
  Button
} from 'react-bootstrap'

import { urlActions } from './_actions'


const App = () => {
  const [fields, setFields] = useState({
    originalUrlInput: '',
    shortenedUrlInput: ''
  })

  const { originalUrlInput, shortenedUrlInput } = fields
  const shortenedUrlRes = useSelector(state => state.url.shortenedUrl) || 'www.example.com'
  const decodedUrlRes = useSelector(state => state.url.originalUrl) || 'null'
  const dispatch = useDispatch()

  const handleChange = (evt) => {
    const { name, value } = evt.target
    setFields(fields => ({ ...fields, [name]: value }))
  }

  const handleShortenUrlSubmit = (evt) => {
    evt.preventDefault()

    if (originalUrlInput) {
      dispatch(urlActions.encode(originalUrlInput))
    }
  }

  const handleDecodeUrlSubmit = (evt) => {
    evt.preventDefault()

    if (shortenedUrlInput) {
      dispatch(urlActions.decode(shortenedUrlInput))
    }
  }

  return (
    <BrowserRouter>
      <Container className='align-items-center justify-content-center'>
        <Form className='d-flex' onSubmit={handleShortenUrlSubmit}>
          <FormControl type='text' name='originalUrlInput' placeholder='Shorten your link'
            className='me-2'
            value={originalUrlInput}
            onChange={handleChange}
          />
          <Button variant='outline-success' style={{display: 'flex'}} className='me-2' type='submit'>
            Shorten
            {/* { isLoggingIn && <span className='spinner-border spinner-border-sm ms-1 my-auto'></span> } */}
          </Button>
        </Form>
        <a href="#">{ shortenedUrlRes }</a>
        <Form className='d-flex mt-2' onSubmit={handleDecodeUrlSubmit}>
          <FormControl type='text' name='shortenedUrlInput' placeholder='Decode your shortened link'
            className='me-2'
            value={shortenedUrlInput}
            onChange={handleChange}
          />
          <Button variant='outline-primary' style={{display: 'flex'}} className='me-2' type='submit'>
            Decode
            {/* { isLoggingIn && <span className='spinner-border spinner-border-sm ms-1 my-auto'></span> } */}
          </Button>
          {/* <Link to='/register' className='btn btn-link'>Shorten</Link> */}
        </Form>
        <a href="#">{ decodedUrlRes }</a>
      </Container>
    </BrowserRouter>
  )
}

export default App;
