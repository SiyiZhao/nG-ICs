import numpy as np
import argparse  
import MAS_library as MASL
import Pk_library as PKL

import bigfile

def read_bigfile(filename, dataset):
    # 打开 BigFile 文件
    with bigfile.File(filename) as bf:
        # 读取指定的数据集
        data = bf[dataset][:]
    return data

def mass_assignment(filename, dataset, grid, BoxSize, MAS, verbose):
    pos = read_bigfile(filename, dataset)
    delta = np.zeros((grid,grid,grid), dtype=np.float32)
    MASL.MA(pos, delta, BoxSize, MAS, verbose=verbose)
    return delta

def main(snapshot, format, grid, ptypes, MAS, do_RSD, axis, verbose, BoxSize, threads):
    # Compute the effective number of particles/mass in each voxel
    if format == 'gadget':
        print('Reading Gadget snapshot')
        delta = MASL.density_field_gadget(snapshot, ptypes, grid, MAS, do_RSD, axis, verbose)
    elif format == 'bigfile':
        print('Reading BigFile snapshot')
        dataset = '1/Position' 
        delta = mass_assignment(snapshot, dataset, grid, BoxSize, MAS, verbose)

    # compute density contrast: delta = rho/<rho> - 1
    delta /= np.mean(delta, dtype=np.float64)
    delta -= 1.0

    # compute power spectrum
    Pk = PKL.Pk(delta, BoxSize, axis, MAS, threads, verbose)

    return Pk

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Calculate power spectrum using Pk.')
    parser.add_argument('--snapshot', type=str, required=True, help='The snapshot file name.')
    parser.add_argument('--format', type=str, default='gadget', help='The type of the snapshot file (e.g., gadget, bigfile).')
    parser.add_argument('--grid', type=int, default=512, help='The grid size.')
    parser.add_argument('--ptypes', type=int, nargs='+', default=[1], help='Particle types (e.g., CDM + neutrinos).')
    parser.add_argument('--MAS', type=str, default='CIC', help='Mass Assignment Scheme.')
    parser.add_argument('--do_RSD', type=bool, default=False, help='Whether to include redshift-space distortions.')
    parser.add_argument('--axis', type=int, default=0, help='The axis along which to apply RSD.')
    parser.add_argument('--verbose', type=bool, default=True, help='Whether to print information on the progress.')
    parser.add_argument('--BoxSize', type=float, required=True, help='The size of the simulation box.')
    parser.add_argument('--threads', type=int, default=1, help='Number of threads to use.')
    parser.add_argument('--output', type=str, default='output.npz', help='The output file name.')

    args = parser.parse_args()
    Pk = main(args.snapshot, args.format, args.grid, args.ptypes, args.MAS, args.do_RSD, args.axis, args.verbose, args.BoxSize, args.threads)

    # 3D P(k)
    k       = Pk.k3D
    Pk0     = Pk.Pk[:,0] #monopole
    Nmodes  = Pk.Nmodes3D
        
    # save
    np.savez(args.output, k=k, Pk0=Pk0, Nmodes=Nmodes)
    print(f"Results saved to {args.output}")


