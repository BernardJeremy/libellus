import { createAction, handleActions } from 'redux-actions'

export const CLASSES_LOAD = 'CLASSES_LOAD'
export const CLASSES_LOADED = 'CLASSES_LOADED'
export const CLASSES_LOAD_FAIL = 'CLASSES_LOAD_FAIL'

export const load = createAction(CLASSES_LOAD, ({subjectId, termId}) => {
  return {
    types: [CLASSES_LOAD, CLASSES_LOADED, CLASSES_LOAD_FAIL],
    promise: (client) => client.get('/subjects/' + subjectId + '/classes', {params: {term: termId}})
  }
})

export const actions = {
  load
}

// ------------------------------------
// Reducer
// ------------------------------------
export default handleActions({
  [CLASSES_LOAD]: (state) => { return {...state, loading: true, failure: false, content: []} },
  [CLASSES_LOADED]: (state, { result }) => {
    return {...state, loading: false, failure: false, content: result}
  },
  [CLASSES_LOAD_FAIL]: (state, { payload }) => {
    return {...state, loading: false, failure: true, content: []}
  }
}, {loading: false, failure: false, content: []})
