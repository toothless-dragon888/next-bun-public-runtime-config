import getConfig from 'next/config'
import {GetServerSideProps} from "next";

const { publicRuntimeConfig } = getConfig()
export default function Home() {

  return (
   <div className="text-center py-6">
     <p className="uppercase">DATA FROM ENV :  {publicRuntimeConfig.NAME}</p>
   </div>
  );
}

export const getServerSideProps: GetServerSideProps = async () => {
    return {
        props: {},
    };
};
