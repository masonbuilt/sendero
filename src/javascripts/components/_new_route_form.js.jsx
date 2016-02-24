var NewRouteForm = React.createClass({

  getInitialState: function() {
    return {name: '', info: '', grade_id: ''};
  },

  handleNameChange: function(e) {
    this.setState({name: e.target.value});
  },

  handleInfoChange: function(e) {
    this.setState({info: e.target.value});
  },

  handleGradeChange: function(e) {
    this.setState({grade_id: e.target.value})
  },

  handleSubmit: function(e) {
    e.preventDefault();
    var name = this.state.name.trim();
    var info = this.state.info.trim();
    var grade_id = this.state.grade_id;
    if (!name || !info || !grade_id) {
      return;
    }
    this.props.onRouteSubmit({name: name, info: info, grade_id: grade_id});
    this.setState({name: '', info: '', grade_id: ''});
  },

  render: function() {
    return(
      <form onSubmit={this.handleSubmit} className="newRouteForm">
        <input
          type="text"
          placeholder="Route name"
          value={this.state.name}
          onChange={this.handleNameChange}
        />
        <input
          type="text"
          placeholder="Describe this route..."
          value={this.state.info}
          onChange={this.handleInfoChange}
        />
        <GradeSelect onSelectChange={this.handleGradeChange} />
        <input type="submit" value="Create" />
      </form>
    );
  }
});