export type AdminClient = {
  from: (relation: string) => any;
};

export type AccountRow = {
  email: string;
  failed_attempts: number | null;
  locked_until: string | null;
  "earliest-attainment"?: string | null;
};

export type StoreRow = {
  id: number;
  session_id: string;
  session_expiration: string;
  username: string;
  branch: string;
  time_in: string;
};

export type StoreSessionResult = {
  sessionId: string;
  isReturning: boolean;
  store: StoreRow;
};

export type StoreSessionBlocked = {
  blocked: true;
  message: string;
};

export type ResolveStoreSessionResult =
  | StoreSessionResult
  | StoreSessionBlocked
  | { error: string };
