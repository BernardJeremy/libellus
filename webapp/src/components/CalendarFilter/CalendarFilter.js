import React, { PropTypes } from 'react'
import { connect } from 'react-redux'
import { changeTerm, changeSubject } from 'redux/modules/filters'
import { load as loadTerms } from 'redux/modules/terms'
import { load as loadSubjects } from 'redux/modules/subjects'
// import classes from './CalendarFilter.scss'

const mapStateToProps = (state) => ({
  filters: state.filters,
  terms: state.terms.content,
  subjects: state.subjects.content
})
export class CalendarFilter extends React.Component {
  static propTypes = {
    filters: PropTypes.object.isRequired,
    changeTerm: PropTypes.func.isRequired,
    changeSubject: PropTypes.func.isRequired,
    loadTerms: PropTypes.func.isRequired,
    loadSubjects: PropTypes.func.isRequired,
    terms: PropTypes.arrayOf(PropTypes.object),
    subjects: PropTypes.arrayOf(PropTypes.object)
  };

  componentDidMount () {
    this.props.loadTerms()
    this.props.loadSubjects()
  }

  termChanged (e) {
    this.props.changeTerm(e.target.value)
  }

  subjectChanged (e) {
    this.props.changeSubject(e.target.value)
  }

  render () {
    const terms = this.props.terms.map((term) =>
      <option value={term.id} key={'term_' + term.id}>{ term.name }</option>
    )
    const subjects = this.props.subjects.map((subject) =>
      <option value={subject.id} key={'subject_' + subject.id}>{ subject.name }</option>
    )

    return (
      <div className='container-fluid'>
        <div className='row'>
          <div className='form-group col-md-6'>
            <label>Term</label>
            <select value={this.props.filters.termId} onChange={this.termChanged.bind(this)} className='form-control'>
              {terms}
            </select>
          </div>
          <div className='form-group col-md-6'>
            <label>Subject</label>
            <select value={this.props.filters.subjectId} onChange={this.subjectChanged.bind(this)} className='form-control'>
              {subjects}
            </select>
          </div>
        </div>
      </div>
    )
  }
}

export default connect(mapStateToProps, {changeTerm, changeSubject, loadTerms, loadSubjects})(CalendarFilter)
