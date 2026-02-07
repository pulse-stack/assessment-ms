export interface Response<T> {
    success: boolean;
    message: String | undefined | null;
    data: T | undefined | null;
}
