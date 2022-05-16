import * as C from './styles';
import { Item } from '../../types/Item';
import { formaDate } from '../../helpers/dateFilter';
import { categories } from '../../database/categories';

type Props = {
    item: Item
}

export const TableItem = ({ item }: Props) => {
    return (
        <C.TableLine>
            <C.TableColumn>{formaDate(item.date)}</C.TableColumn>
            <C.TableColumn>
                <C.Category color={categories[item.category].color}>
                    {categories[item.category].title}
                </C.Category>
            </C.TableColumn>
            <C.TableColumn>{item.title}</C.TableColumn>
            <C.TableColumn>
                <C.Value color={categories[item.category].expense ? 'red' : 'green'}>
                    {item.value.toLocaleString('pt-BR', {style: 'currency', currency: 'BRL'})}
                </C.Value>
            </C.TableColumn>
        </C.TableLine>
    );
}