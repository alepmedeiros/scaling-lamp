const Checkbox = (props) => {
    return (
        <div className="form-group">
            <div className="checkbox">
                <label>
                    <input type="checkbox" value={props.value}/> {props.label}
                </label>
            </div>
        </div>
    );
}

export default Checkbox;