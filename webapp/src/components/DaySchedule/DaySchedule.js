import React, { PropTypes } from 'react'
import { connect } from 'react-redux'
import _ from 'lodash'
import classes from './DaySchedule.scss'
import ScheduleTick from './ScheduleTick/ScheduleTick'

const daysName = [ 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday' ]

const mapStateToProps = (state) => ({
  // classes: state.classes.content
})
export class DaySchedule extends React.Component {
  static propTypes = {
    day: PropTypes.number.isRequired
  };

  render () {
    const hoursTicks = _.times(24, (hour) => <ScheduleTick hour={hour} day={this.props.day} key={hour} />)

    return (
      <div className={classes['container']}>
        <p className={classes['day-title']}>{daysName[this.props.day]}</p>
        <div className={classes['scheldule-container']}>
          <div className={classes['ticks-container']}>
            {hoursTicks}
          </div>
        </div>
      </div>
    )
  }
}

export default connect(mapStateToProps, {})(DaySchedule)
