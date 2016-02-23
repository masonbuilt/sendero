var Route = React.createClass({
  render: function() {
    return (
      <div className="route">
        <h3 className="routeName">
          {this.props.name}
        </h3>
        <a href={"/routes/" + this.props.id}>{this.props.info}</a>
      </div>
    );
  }
});