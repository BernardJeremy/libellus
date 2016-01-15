import superagent from 'superagent'

const mocks = {
  ['/terms']: [{
    id: '0',
    name: 'Spring 2016'
  }, {
    id: '1',
    name: 'Winter 2016'
  }],
  ['/subjects']: [
    {
      'id': '0',
      'name': 'Computer Science & Computer Engineering',
      'code': 'CECS'
    },
    {
      'id': '1',
      'name': 'Economic',
      'code': 'ECON'
    },
    {
      'id': '.. + 1',
      'name': 'American Language Institute',
      'code': 'ALI'
    }
  ]

}

const methods = ['get', 'post', 'put', 'patch', 'del']
const client = {}
methods.forEach((method) =>
  client[method] = (path, { params, data } = {}) => new Promise((resolve, reject) => {
    if (mocks[path]) {
      return resolve(mocks[path])
    }
    const request = superagent[method](path)
    if (params) {
      request.query(params)
    }
    if (data) {
      request.send(data)
    }
    request.end((err, { body } = {}) => err ? reject(body || err) : resolve(body))
  }
))

export default function clientMiddleware ({dispatch, getState}) {
  return next => action => {
    if (typeof action === 'function') {
      return action(dispatch, getState)
    }

    const { payload } = action
    if (!payload) {
      return next(action)
    }
    const { promise, types, ...rest } = payload
    if (!promise) {
      return next(action)
    }

    const [REQUEST, SUCCESS, FAILURE] = types
    next({...rest, type: REQUEST})
    return promise(client).then(
      (result) => next({...rest, result, type: SUCCESS}),
      (error) => {
        console.error('Error in middleware promise', error)
        return next({...rest, error, type: FAILURE})
      }
    ).catch((error) => {
      console.error('Error in middleware promise', error)
      next({...rest, error, type: FAILURE})
    })
  }
}
