var GradeSelectOption = React.createClass({
  render: function() {
    return(
      <option value={this.props.value}>
        {this.props.name}
      </option>
    );
  }
});