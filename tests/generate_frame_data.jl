using InstantFrame 

H = 100.0 
W = 100.0

material = InstantFrame.Material(names=["steel"], E=[29500.0], ν=[0.3], ρ=[492.0 / 32.17 / 12^4 / 1000])  ##ρ = kips * s^2 / in^4

cross_section = InstantFrame.CrossSection(names=["beam", "column"], A=[1.0, 2.0], Iy=[3.1, 4.2], Iz= [2.4, 6.5], J=[0.001, 0.002])

connection = InstantFrame.Connection(names=["rigid", "pinned"], stiffness=(ux=[Inf, Inf], uy=[Inf, Inf], uz=[Inf, Inf], rx=[Inf, Inf], ry=[Inf, 0.0], rz=[Inf, 0.0]))

node = InstantFrame.Node(numbers=[1, 2, 3, 4], coordinates=[(0.0, 0.0, 0.0), (0.0, H, 0.0), (W, H, 0.0), (W, 0.0, 0.0)])

element = InstantFrame.Element(numbers=[1, 2, 3], nodes = [(1,2), (2,3), (3,4)], orientation = [0.0, 0.0, 0.0, 0.0, 0.0], connections=[("rigid", "rigid"), ("rigid", "rigid"), ("rigid", "rigid")], cross_section= ["beam", "column"], material = ["steel", "steel", "steel"], types=["frame", "frame", "frame"])

support = InstantFrame.Support(nodes=[1, 4], stiffness=(uX=[Inf,Inf], uY=[Inf,Inf], uZ=[Inf,Inf], rX=[Inf,Inf], rY=[Inf,Inf], rZ=[Inf,Inf]))

uniform_load = InstantFrame.UniformLoad(nothing)

point_load = InstantFrame.PointLoad(labels = ["gravity"], nodes=[2], magnitudes=(FX=[0.0], FY=[-0.500], FZ=[0.0], MX=[0.0], MY=[0.0], MZ=[0.0]))

model = InstantFrame.solve(node, cross_section, material, connection, element, support, uniform_load, point_load, analysis_type="first order", solution_tolerance = 0.01)


#inputs
#node coordinate matrix, edge (element) connectivity matrix; node input: applied lateral node load matrix, node boundary condition matrix; edge input: elastic modulus E matrix, moment of inertia I matrix;


#outputs
#OneRack is interested in nodal displacements, internal forces, reactions 

#variables!
#E, 


