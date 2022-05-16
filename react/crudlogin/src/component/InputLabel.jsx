const InputLabel = (props) => {
    return (
        <div className="form-group">
            <div className="form-label-group">
                <input className="form-control" id={props.id} placeholder={props.placeholder} type={props.type} name={props.name}/>
                <label htmlFor={props.id}>{props.label}</label>
                <div className="invalid-feedback">
                        {props.invalidFeedbakc}
                </div>
            </div>
        </div>
    );
}

export default InputLabel;