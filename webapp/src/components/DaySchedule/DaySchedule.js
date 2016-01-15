import React, { PropTypes } from 'react'
import { connect } from 'react-redux'
import _ from 'lodash'
import classes from './DaySchedule.scss'
import ScheduleTick from './ScheduleTick/ScheduleTick'

const mapStateToProps = (state) => ({
  classes: state.classes.content
})
export class DaySchedule extends React.Component {
  static propTypes = {
    classes: PropTypes.arrayOf(PropTypes.object),
    day: PropTypes.number.isRequired
  };

  render () {
    const daysName = [ 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday' ]

    const hoursTicks = _.times(24, (hour) => {
      return (
        <ScheduleTick hour={hour} key={hour}/>
      )
    })

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
