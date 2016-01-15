import { createAction, handleActions } from 'redux-actions'

export const SUBJECTS_LOAD = 'SUBJECTS_LOAD'
export const SUBJECTS_LOADED = 'SUBJECTS_LOADED'
export const SUBJECTS_LOAD_FAIL = 'SUBJECTS_LOAD_FAIL'

export const load = createAction(SUBJECTS_LOAD, () => {
  return {
    types: [SUBJECTS_LOAD, SUBJECTS_LOADED, SUBJECTS_LOAD_FAIL],
    promise: (client) => client.get('/subjects')
  }
})

export const actions = {
  load
}

// ------------------------------------
// Reducer
// ------------------------------------
export default handleActions({
  [SUBJECTS_LOAD]: (state) => { return {...state, loading: true, failure: false, content: []} },
  [SUBJECTS_LOADED]: (state, { result }) => {
    return {...state, loading: false, failure: false, content: result}
  },
  [SUBJECTS_LOAD_FAIL]: (state, { payload }) => {
    return {...state, loading: false, failure: true, content: []}
  }
}, {loading: false, failure: false, content: []})
