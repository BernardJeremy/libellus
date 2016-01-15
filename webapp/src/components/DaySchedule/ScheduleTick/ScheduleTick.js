import React, { PropTypes } from 'react'
import { connect } from 'react-redux'
import classes from './ScheduleTick.scss'

const mapStateToProps = (state) => ({
  height: state.scheduleStyle.height
})
export class DaySchedule extends React.Component {
  static propTypes = {
    height: PropTypes.number.isRequired,
    hour: PropTypes.number.isRequired
  };

  render () {
    const hours = [ '1:00am', '2:00am', '3:00am', '4:00am', '5:00am', '6:00am', '7:00am', '8:00am', '9:00am', '10:00am', '11:00am', '12:00am', '1:00pm', '2:00pm', '3:00pm', '4:00pm', '5:00pm', '6:00pm', '7:00pm', '8:00pm', '9:00pm', '10:00pm', '11:00pm', '12:00pm' ]

    const tickStyle = {
      height: this.props.height + 'px'
    }

    return (
      <div className={classes['tick']} style={tickStyle}>
        <p>{hours[this.props.hour]}</p>
      </div>
    )
  }
}

export default connect(mapStateToProps, {})(DaySchedule)
