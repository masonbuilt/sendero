var GenericResourceListItemDiv = React.createClass({
  render: function() {
    return(
      <td className="genericResourceListItemDiv">
        {this.props.value}
      </td>
    );
  }
});