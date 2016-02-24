var LoginPage = React.createClass({
  render: function() {
    return(<div>
              <ul className="list--horiz">
                <li className="list--horiz__item">
                  <a href="">Log In</a>
                </li>
                <li className="list--horiz__item">
                  <a href="">Sign Up</a>
                </li>
              </ul>
              <form className="new_user" id="new_user" action="/users/sign_in" accept-charset="UTF-8" method="post">
                <input name="utf8" type="hidden" value="✓" />
                  <input type="hidden" name="" value=""/>
                      <div className="form-element">
                        <label className="form-element__label" for="user_email">Email</label>
                        <div className="form-element__control">
                          <input autofocus="autofocus" placeholder="email@sendero.com" type="email" value="" name="user[email]" id="user_email" />
                        </div>
                      </div>

                      <div className="form-element">
                        <label className="form-element__label" for="user_password">Password</label>
                        <div className="form-element__control">
                          <input autocomplete="off" placeholder="password" type="password" name="user[password]" id="user_password"/>
                        </div>
                      </div>

                    <div className="form-element">
                        <span className="checkbox">
                          <input name="checkbox" type="hidden" value="0"/>
                          <input className="checkbox__field" id="checkbox--remember" name="checkbox" type="checkbox" value="1" />
                          <label className="checkbox__label" for="checkbox--remember">Remember me</label>
                        </span>
                    </div>

                    <div className="form-element">
                      <input type="submit" name="commit" value="Log in" className="btn--fit"/>
                    </div>

              </form>
    </div>);
  }
});
