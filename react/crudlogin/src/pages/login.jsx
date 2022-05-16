import Checkbox from "../component/Checkbox";
import InputLabel from "../component/InputLabel";
import Button from '../component/Button';

const Login = () => {
    return (
        <div className="container">
            <div className="card card-login mx-auto mt-5">
                <div className="card-header">Login</div>
                <div className="card-body">
                    <form>
                        <InputLabel 
                            id="inputEmail"
                            placeholder="Email address"
                            type="text"
                            name="email"
                            label="Email address"
                            invalidFeedback="Please provide a valid Email."
                        />
                        <InputLabel 
                            id="inputPassword"
                            placeholder="******"
                            type="password"
                            name="password"
                            label="Password"
                            invalidFeedback="Please provide a valid Password."
                        />
                        <Checkbox 
                            value="remember-me"
                            label="Remember Password"
                        />
                        <Button 
                            type="submit"
                            disable="false"
                            label="Login &nbsp;&nbsp;&nbsp;"
                        />
                        <div className="text-center">
                            <a className="d-block small" href="forgot-password.html">Forgot Password?</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    );
}

export default Login;