import { createAction, handleActions } from 'redux-actions'

export const TERMS_LOAD = 'TERMS_LOAD'
export const TERMS_LOADED = 'TERMS_LOADED'
export const TERMS_LOAD_FAIL = 'TERMS_LOAD_FAIL'

export const load = createAction(TERMS_LOAD, () => {
  return {
    types: [TERMS_LOAD, TERMS_LOADED, TERMS_LOAD_FAIL],
    promise: (client) => client.get('/terms')
  }
})

export const actions = {
  load
}

// ------------------------------------
// Reducer
// ------------------------------------
export default handleActions({
  [TERMS_LOAD]: (state) => { return {...state, loading: true, failure: false, content: []} },
  [TERMS_LOADED]: (state, { result }) => {
    return {...state, loading: false, failure: false, content: result}
  },
  [TERMS_LOAD_FAIL]: (state, { payload }) => {
    return {...state, loading: false, failure: true, content: []}
  }
}, {loading: false, failure: false, content: []})
