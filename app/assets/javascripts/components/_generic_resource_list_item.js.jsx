var GenericResourceListItem = React.createClass({
  render: function() {

    var resourceListItemDivs = Object.values(this.props.resource).map(function(resourceValue) {
      return <GenericResourceListItemDiv value={resourceValue}/>;
    });

    return (
      <tr>
        {resourceListItemDivs}
      </tr>
    );
  }
});