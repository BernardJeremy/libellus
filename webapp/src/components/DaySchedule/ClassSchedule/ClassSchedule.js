import React, { PropTypes } from 'react'
import ReactDOM from 'react-dom'
import { connect } from 'react-redux'
import classes from './ClassSchedule.scss'
import { hashCode } from 'utils'
import Paper from 'material-ui/lib/paper'
import randomcolor from 'randomcolor'
import Popover from 'material-ui/lib/popover/popover'
import { selectClassId } from 'redux/modules/classes'

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
  };

  render () {
    const containerStyle = {
      height: this.props.data.time.duration / 60 * this.props.hourHeight,
      backgroundColor: randomcolor({luminosity: 'bright', seed: hashCode(this.props.data.name)})
    }

    if (this.props.data.time.startMinute % 60) {
      containerStyle.top = this.props.hourHeight / 2
    }

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
          targetOrigin={{'horizontal': 'left', 'vertical': 'top'}}>
          <p>coucou</p>
        </Popover>
      </div>
    )
  }
}

export default connect(mapStateToProps, {selectClassId})(ClassSchedule)
