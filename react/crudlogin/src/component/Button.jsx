const Button = (props) => {
    return (
        <div className="form-group">
            <button className="btn btn-primary btn-block" type={props.type} disabled={props.disabel}>{props.label}
            </button>
        </div>
    );
}

export default Button;