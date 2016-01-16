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
  ],
  ['/subjects/0/classes']: [
    {
      'id': '0',
      'name': 'Operating System',
      'code': '326',
      'description': 'xxxxxxxxxxxxxxxxx',
      'room': 'VEC-250',
      'teacher': {
        'name': 'Brian Velasquez',
        'rate': '5',
        'rate_link': 'http://www.ratemyprofessors.com/ShowRatings.jsp?tid=446598'
      },
      'capacity': {
        'total_capacity': '20',
        'enrollment': '12',
        'wait_list': '0'
      },
      'time': [
        {
          'day': 'Mon',
          'start': '9:00',
          'end': '13:30'
        },
        {
          'day': 'Wed',
          'start': '11:30',
          'end': '13:30'
        }
      ]
    },
    {
      'id': '1',
      'name': 'Algorithms & Data Structures',
      'code': '328',
      'description': 'xxxxxxxxxxxxxxxxx',
      'room': 'VEC-250',
      'teacher': {
        'name': 'Brian Velasquez',
        'rate': '5',
        'rate_link': 'http://www.ratemyprofessors.com/ShowRatings.jsp?tid=446598'
      },
      'capacity': {
        'total_capacity': '20',
        'enrollment': '12',
        'wait_list': '0'
      },
      'time': [
        {
          'day': 'Mon',
          'start': '10:30',
          'end': '13:30'
        },
        {
          'day': 'Wed',
          'start': '10:00',
          'end': '13:30'
        }
      ]
    },
    {
      'id': '..+1',
      'name': '.NET Application',
      'code': '475',
      'description': 'xxxxxxxxxxxxxxxxx',
      'room': 'VEC-250',
      'teacher': {
        'name': 'Brian Velasquez',
        'rate': '5',
        'rate_link': 'http://www.ratemyprofessors.com/ShowRatings.jsp?tid=446598'
      },
      'capacity': {
        'total_capacity': '20',
        'enrollment': '12',
        'wait_list': '0'
      },
      'time': [
        {
          'day': 'Mon',
          'start': '10:30',
          'end': '13:30'
        },
        {
          'day': 'Wed',
          'start': '10:30',
          'end': '15:30'
        }
      ]
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
