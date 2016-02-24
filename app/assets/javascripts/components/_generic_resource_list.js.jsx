var GenericResourceList = React.createClass({

  getInitialState: function() {
    return {
      resources: [],
      attributes: this.props.data
    };
  },

  componentDidMount: function() {
    this.loadResourceFromServer();
    setInterval(this.loadResourceFromServer, this.props.pollInterval);
  },

  loadResourceFromServer: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({resources: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  render: function() {

    var that = this;

    var genericResourceListItems = this.state.resources.map(function(resource) {
      return (
        <GenericResourceListItem attributes={that.state} resource={resource} />
      );
    });

    var genericResourceListHeaders = Object.keys(this.state.attributes).map(function(attribute) {
      return (
        <th>{attribute}</th>
      );
    });

    return (
      <div className="genericResourceList">
        <table className="genericResourceListTable">
          <tbody>
            <tr>
              {genericResourceListHeaders}
            </tr>
            {genericResourceListItems}
          </tbody>
        </table>
      </div>
    );
  }
});
