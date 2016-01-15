import React from 'react'
import { connect } from 'react-redux'
import classes from './HomeView.scss'

import CalendarFilter from 'components/CalendarFilter/CalendarFilter.js'
import Calendar from 'components/Calendar/Calendar.js'

const mapStateToProps = (state) => ({
})
export class HomeView extends React.Component {
  static propTypes = {
  };

  render () {
    return (
      <div className='container-fluid'>
        <div className={classes['titleContainer']}>
          <h1>Libellus for CSULB</h1>
        </div>
        <CalendarFilter/>
        <Calendar/>
      </div>
    )
  }
}

export default connect(mapStateToProps, {})(HomeView)
