import axios from "axios";

const { get } = axios;

const getSentence = async () => {
  const jokeData = await get("https://api.quotable.io/random");

  return jokeData.data.content.split(" ");
};

export default getSentence;
