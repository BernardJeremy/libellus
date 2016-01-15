import React, { PropTypes } from 'react'
import { connect } from 'react-redux'
import classes from './ClassSchedule.scss'
import Paper from 'material-ui/lib/paper'

const mapStateToProps = (state) => ({
  hourHeight: state.scheduleStyle.height
})
export class ClassSchedule extends React.Component {
  static propTypes = {
    data: PropTypes.object.isRequired,
    hourHeight: PropTypes.number.isRequired
  };

  get startTime () {
    const [hours, minutes] = this.props.data.time.start.split(':')
    return Number(hours) * 60 + Number(minutes)
  }

  get endTime () {
    const [hours, minutes] = this.props.data.time.end.split(':')
    return Number(hours) * 60 + Number(minutes)
  }

  render () {
    const containerStyle = {
      top: this.startTime / 60 * this.props.hourHeight,
      height: (this.endTime - this.startTime) / 60 * this.props.hourHeight
    }

    return (
      <div>
        <Paper zindex={1} className={classes['container']} style={containerStyle}>
          <p>{this.props.data.name}</p>
        </Paper>
      </div>
    )
  }
}

export default connect(mapStateToProps, {})(ClassSchedule)
