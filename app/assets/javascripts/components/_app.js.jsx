var App = React.createClass({
  render: function() {
    return(
      <RouteList url="/routes" pollInterval={5000} />
    );
  }
});