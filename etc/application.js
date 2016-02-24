//= require jquery
//= require jquery_ujs
//= require turbolinks

//= require_tree .

//= require react
//= require react_ujs
//= require components

//= require react_router
//= require react_router_ujs

var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;

ReactRouter.run(routes, function (Handler) {
  ReactDOM.render(<Handler/>, document.body);
});