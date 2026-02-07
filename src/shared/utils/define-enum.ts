type StringTuple = readonly string[];

type EnumLike<T extends StringTuple> = Readonly<{
    [K in T[number]]: K;
}>;

export type TypeOf<T> = T[keyof T];

export function defineEnum<const T extends StringTuple>(
    values: T,
): EnumLike<T> {
    const entries = values.map((v) => [v, v]);
    return Object.fromEntries(entries) as EnumLike<T>;
}
