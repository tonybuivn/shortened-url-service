import { URL_CONSTANTS } from '../_constants'
import { baseConfigs } from '../_configs'

const encode = (originalUrlInput) => (dispatch) => {
  dispatch(encode_request)

  const request = {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ original_url: originalUrlInput })
  }

  return fetch(`${baseConfigs.API_URL}/encode`, request)
    .then(handleResponse)
    .then(res => {
      dispatch(encode_success(res.shortened_url))
      // history.push(from)
      },
      error => {
        dispatch(encode_failure(error))
      })
}

const decode = (shortenedUrlInput) => (dispatch) => {
  dispatch(decode_request)

  const request = {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ shortened_url: shortenedUrlInput })
  }

  return fetch(`${baseConfigs.API_URL}/decode`, request)
    .then(handleResponse)
    .then(res => {
      dispatch(decode_success(res.original_url))
      // history.push(from)
      },
      error => {
        dispatch(decode_failure(error))
      })
}

const encode_request = () => ({ type: URL_CONSTANTS.ENCODE_REQUEST })
const encode_success = (shortenedUrl) => ({ type: URL_CONSTANTS.ENCODE_SUCCESS, shortenedUrl })
const encode_failure = (error) => ({ type: URL_CONSTANTS.ENCODE_FAILURE, error })
const decode_request = () => ({ type: URL_CONSTANTS.DECODE_REQUEST })
const decode_success = (originalUrl) => ({ type: URL_CONSTANTS.DECODE_SUCCESS, originalUrl })
const decode_failure = (error) => ({ type: URL_CONSTANTS.DECODE_FAILURE, error })

const handleResponse = (res) => {
  return res.text().then(strData => {
    const data = strData && JSON.parse(strData)
    if(data.error) {
      const error = (data && data.error) || res.statusText
      return Promise.reject(error)
    }
    
    return data
  })
}

export const urlActions = {
  encode,
  decode
}
