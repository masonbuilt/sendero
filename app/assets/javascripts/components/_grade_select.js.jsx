var GradeSelect = React.createClass({

  getInitialState: function() {
    return {
      data: {
        grades: []
      }
    };
  },

  componentDidMount: function() {
    this.serverRequest = $.get("/grades.json", function (result) {
      this.setState({
        data: {grades: result}
      });
    }.bind(this));
  },

  componentWillUnmount: function() {
    this.serverRequest.abort();
  },

  handleSelectChange: function(e) {
    this.props.onSelectChange(e);
  },

  render: function() {
    var gradeSelectOptions = this.state.data.grades.map(function(grade) {
      return(
        <GradeSelectOption name={grade.name} value={grade.id} key={grade.id} />
      );
    });

    return (
      <select name={this.props.name} id={this.props.id} onChange={this.handleSelectChange} >
        {gradeSelectOptions}
      </select>
    );
  }
});