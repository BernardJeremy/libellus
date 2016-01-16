import React, { PropTypes } from 'react'
import ReactDOM from 'react-dom'
import { connect } from 'react-redux'
import classes from './ClassSchedule.scss'
import { hashCode } from 'utils'
import Paper from 'material-ui/lib/paper'
import randomcolor from 'randomcolor'
import classnames from 'classnames'
import Popover from 'material-ui/lib/popover/popover'
import Divider from 'material-ui/lib/divider'
import { selectClassId } from 'redux/modules/classes'
import _ from 'lodash'
import FontAwesome from 'react-fontawesome'

const mapStateToProps = (state) => ({
  hourHeight: state.scheduleStyle.height,
  selectedClassId: state.classes.selectedClassId
})
export class ClassSchedule extends React.Component {
  static propTypes = {
    data: PropTypes.object.isRequired,
    hourHeight: PropTypes.number.isRequired,
    selectedClassId: PropTypes.string,
    selectClassId: PropTypes.func.isRequired
  };

  constructor () {
    super()
    this.state = {popoverOpened: false, anchor: null}
  }

  onClick = () => {
    this.props.selectClassId(this.props.data.id)
    this.setState({popoverOpened: true, anchor: ReactDOM.findDOMNode(this.refs.container)})
  };

  popoverClosed = () => {
    this.setState({popoverOpened: false})
    this.props.selectClassId(null)
  };

  render () {
    const containerStyle = {
      height: this.props.data.time.duration / 60 * this.props.hourHeight,
      backgroundColor: randomcolor({luminosity: 'bright', seed: hashCode(this.props.data.name)})
    }

    if (this.props.data.time.startMinute % 60) {
      containerStyle.top = this.props.hourHeight / 2
    }

    const stars = _.times(Number(this.props.data.teacher.rate), (i) => <FontAwesome name='star' key={i} />)

    return (
      <div>
        <Paper
          zDepth={this.state.popoverOpened ? 3 : 1}
          className={classnames(classes['container'], {[classes['non-selected']]: this.props.selectedClassId && this.props.selectedClassId !== this.props.data.id})}
          style={containerStyle}
          onClick={this.onClick}
          ref='container'>
          <p className={classes['name']}>{this.props.data.name}</p>
        </Paper>
        <Popover
          open={this.state.popoverOpened}
          anchorEl={this.state.anchor}
          onRequestClose={this.popoverClosed}
          anchorOrigin={{'horizontal': 'right', 'vertical': 'top'}}
          targetOrigin={{'horizontal': 'left', 'vertical': 'top'}}
          className={classes['popover']}>
          <p className={classes['title']}>{this.props.data.code} {this.props.data.name}</p>
          <p className={classes['description']}>{this.props.data.description}</p>
          <p className={classes['room']}>{this.props.data.room} - {this.props.data.teacher.name} <a target='_blank' href={this.props.data.teacher.rate_link}>{stars}</a></p>
          <Divider />
          <p className={classes['capacity']}>Capacity: {this.props.data.capacity.total_capacity}</p>
          <div className={classes['capacity-details']}>
            <p className={classes['enrolment']}>Enrolment: {this.props.data.capacity.enrollment}</p>
            <p className={classes['seats-left']}>Seats Left: {this.props.data.capacity.total_capacity - this.props.data.capacity.enrollment}</p>
          </div>
        </Popover>
      </div>
    )
  }
}

export default connect(mapStateToProps, {selectClassId})(ClassSchedule)
