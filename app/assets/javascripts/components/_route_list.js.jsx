var RouteList = React.createClass({

  getInitialState: function() {
    return {data: []};
  },

  handleRouteSubmit: function(route) {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      type: 'POST',
      data: {route: route},
      success: function(data) {
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  componentDidMount: function() {
    this.loadRoutesFromServer();
    setInterval(this.loadRoutesFromServer, this.props.pollInterval);
  },

  loadRoutesFromServer: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  render: function() {

    var routeListItems = this.state.data.map(function(route) {
      return (
        <RouteListItem info={route.info} key={route.id} name={route.name} id={route.id} ownerId={route.owner_id} grade={route.grade} />
      );
    });

    return (
      <div className="routeList">
        <table className="routeListTable">
          <tbody>
            {routeListItems}
          </tbody>
        </table>
        <NewRouteForm onRouteSubmit={this.handleRouteSubmit} />
      </div>
    );
  }
});
