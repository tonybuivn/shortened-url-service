import { URL_CONSTANTS } from '../_constants'

const url = (state = {}, action) => {
  switch(action.type) {
    case URL_CONSTANTS.ENCODE_REQUEST:
      return { ...state, isEncoding: true }
    
    case URL_CONSTANTS.ENCODE_SUCCESS:
      return { ...state, isEncoding: false, shortenedUrl: action.shortenedUrl }

    case URL_CONSTANTS.ENCODE_FAILURE:
      return { ...state, isEncoding: false, error: action.error }

    case URL_CONSTANTS.DECODE_REQUEST:
      return { ...state, isDecoding: true }
    
    case URL_CONSTANTS.DECODE_SUCCESS:
      return { ...state, isDecoding: false, originalUrl: action.originalUrl }

    case URL_CONSTANTS.DECODE_FAILURE:
      return { ...state, isDecoding: false, error: action.error }

    default:
      return state
  }
}

export default url
