import React, { PropTypes } from 'react'
import { connect } from 'react-redux'
import shouldPureComponentUpdate from 'react-pure-render/function'

const mapStateToProps = (state, props) => ({
  classNotSelected: state.classes.selectedClassId && state.classes.selectedClassId !== props.data.id
})
export class SelectedClassWrapper extends React.Component {
  static propTypes = {
    classNotSelected: PropTypes.bool,
    children: PropTypes.element,
    data: PropTypes.object.isRequired
  };

  shouldComponentUpdate = shouldPureComponentUpdate;

  render () {
    const containerStyle = {
      opacity: this.props.classNotSelected ? 0.3 : 1,
      transition: 'opacity 0.2s ease'
    }

    return (
      <div style={containerStyle}>
        {this.props.children}
      </div>
    )
  }
}

export default connect(mapStateToProps)(SelectedClassWrapper)
