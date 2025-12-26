import { compare, genSalt, hash } from "bcryptjs";

export default class PasswordHash {
  static async hashPassword(password: string): Promise<string> {
    const salt = await genSalt(10);
    return await hash(password, salt);
  }

  static async comparePassword(
    password: string,
    hash: string
  ): Promise<boolean> {
    return await compare(password, hash);
  }
}
