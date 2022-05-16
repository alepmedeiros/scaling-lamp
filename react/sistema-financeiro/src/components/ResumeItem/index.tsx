import * as C from "./styles";

type Props = {
    title: string;
    value: number;
    color?: string;
}

export const ResumeItem = ({ title, value, color }: Props) => {
    return (
        <C.Container>
            <C.Title>{title}</C.Title>
            <C.Info color={color}>{value.toLocaleString('pt-BR', {style: 'currency', currency: 'BRL'})}</C.Info>
        </C.Container>
    );
}