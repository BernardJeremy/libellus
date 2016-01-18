import React, { PropTypes } from 'react'
import ReactDOM from 'react-dom'
import { connect } from 'react-redux'
import classes from './ClassSchedule.scss'
import { hashCode } from 'utils'
import Paper from 'material-ui/lib/paper'
import randomcolor from 'randomcolor'
// import classnames from 'classnames'
import Popover from 'material-ui/lib/popover/popover'
import Divider from 'material-ui/lib/divider'
import { selectClassId, addToList as addCourseToList, removeFromList as removeCourseFromList } from 'redux/modules/classes'
import _ from 'lodash'
import FontAwesome from 'react-fontawesome'
import RaisedButton from 'material-ui/lib/raised-button'
import shouldPureComponentUpdate from 'react-pure-render/function'

const mapStateToProps = (state, props) => ({
  hourHeight: state.scheduleStyle.height,
  classInList: _.contains(state.classes.registeredClasses, props.data.id)
})
export class ClassSchedule extends React.Component {
  static propTypes = {
    data: PropTypes.object.isRequired,
    hourHeight: PropTypes.number.isRequired,
    selectClassId: PropTypes.func.isRequired,
    addCourseToList: PropTypes.func.isRequired,
    removeCourseFromList: PropTypes.func.isRequired,
    classInList: PropTypes.bool.isRequired
  };

  shouldComponentUpdate = shouldPureComponentUpdate;

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

  onToggleCourse = () => {
    if (this.props.classInList) {
      this.props.removeCourseFromList(this.props.data.id)
    } else {
      this.props.addCourseToList(this.props.data.id)
    }
  };

  render () {
    const containerStyle = {
      height: this.props.data.time.duration / 60 * this.props.hourHeight,
      backgroundColor: randomcolor({luminosity: 'bright', seed: hashCode(this.props.data.name)}).split('-').join('')
    }

    if (this.props.data.time.startMinute % 60) {
      containerStyle.top = this.props.hourHeight / 2
    }

    const stars = _.times(Number(this.props.data.teacher.rate), (i) => <FontAwesome name='star' key={i} />)

    return (
      <div>
        <Paper
          zDepth={this.state.popoverOpened ? 3 : 1}
          className={classes['container']}
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
          className={classes['popover']}
          autoCloseWhenOffScreen={false}>
          <p className={classes['title']}>{this.props.data.code} {this.props.data.name}</p>
          <p className={classes['description']}>{this.props.data.description}</p>
          <p className={classes['room']}>{this.props.data.room} - {this.props.data.teacher.name} <a target='_blank' href={this.props.data.teacher.rate_link}>{stars}</a></p>
          <Divider />
          <p className={classes['capacity']}>Capacity: {this.props.data.capacity}</p>
          <div className={classes['capacity-details']}>
            <p className={classes['enrolment']}>Enrolment: {this.props.data.enrollment}</p>
            <p className={classes['seats-left']}>Seats Left: {this.props.data.capacity - this.props.data.enrollment}</p>
          </div>
          <Divider />
          <RaisedButton style={{marginTop: 5}} label={this.props.classInList ? 'Remove from list' : 'Add to list'} primary onTouchTap={this.onToggleCourse} fullWidth/>
        </Popover>
      </div>
    )
  }
}

export default connect(mapStateToProps, {selectClassId, addCourseToList, removeCourseFromList})(ClassSchedule)
